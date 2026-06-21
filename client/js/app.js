// SPSearch — Client Logic
// ========================================

var SPSearch = (function () {
    var apiBase = '/api/search';

    function getCreds() {
        try {
            return JSON.parse(sessionStorage.getItem('spsearch_creds'));
        } catch { return null; }
    }

    function setCreds(c) {
        sessionStorage.setItem('spsearch_creds', JSON.stringify(c));
    }

    function clearCreds() {
        sessionStorage.removeItem('spsearch_creds');
        sessionStorage.removeItem('spsearch_search');
    }

    function getSearchParams() {
        try {
            return JSON.parse(sessionStorage.getItem('spsearch_search'));
        } catch { return null; }
    }

    function setSearchParams(p) {
        sessionStorage.setItem('spsearch_search', JSON.stringify(p));
    }

    function showError(msg) {
        var box = $('#errorBox');
        box.text(msg).removeClass('hidden');
    }

    function hideError() {
        $('#errorBox').addClass('hidden');
    }

    // ---- PAGE 1: CONNECT ----
    function initPage1() {
        // If already connected, redirect to page 2
        if (getCreds()) {
            window.location.href = 'page2.html';
            return;
        }

        // Toggle SQL auth fields
        function toggleAuthFields() {
            var trusted = $('#trustedAuth').is(':checked');
            if (trusted) {
                $('#sqlAuthFields').addClass('hidden');
            } else {
                $('#sqlAuthFields').removeClass('hidden');
            }
        }

        $('#trustedAuth').on('change', toggleAuthFields);
        toggleAuthFields();

        $('#btnSign').on('click', function () {
            hideError();
            var trusted = $('#trustedAuth').is(':checked');
            var creds = {
                server: $('#server').val().trim(),
                username: trusted ? '' : $('#username').val().trim(),
                password: trusted ? '' : $('#password').val(),
                port: parseInt($('#port').val(), 10) || 1433,
                trustedConnection: trusted,
                trustServerCertificate: $('#trustCert').is(':checked')
            };

            if (!creds.server) {
                showError('Server is required.');
                return;
            }

            if (!trusted && !creds.username) {
                showError('Username is required.');
                return;
            }

            var btn = $(this);
            btn.prop('disabled', true).text('Connecting...');

            $.ajax({
                url: apiBase + '/connect',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(creds),
                success: function () {
                    setCreds(creds);
                    window.location.href = 'page2.html';
                },
                error: function (xhr) {
                    var msg = 'Connection failed.';
                    try { var r = xhr.responseJSON; if (r && r.message) msg = r.message; } catch {}
                    showError(msg);
                    btn.prop('disabled', false).text('SIGN IN');
                }
            });
        });

        // Enter key triggers sign in
        $('#password').on('keydown', function (e) {
            if (e.key === 'Enter') $('#btnSign').click();
        });
    }

    // ---- PAGE 2: SEARCH CONFIG ----
    function initPage2() {
        var creds = getCreds();
        if (!creds) {
            window.location.href = 'index.html';
            return;
        }

        var tableSelect = $('#tableSelect');
        var databaseSelect = $('#databaseSelect');
        var selectAllLink = $('#selectAllTables');
        var savedParams = getSearchParams();

        // Init Select2 on database
        databaseSelect.select2({ width: '100%' });

        // Init Select2 on table (multi-select)
        tableSelect.select2({
            width: '100%',
            placeholder: 'All Tables (select to narrow)'
        });

        // Load databases
        $.ajax({
            url: apiBase + '/databases',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(creds),
            success: function (dbs) {
                databaseSelect.find('option:not(:first)').remove();
                dbs.forEach(function (db) {
                    databaseSelect.append('<option value="' + $('<span>').text(db.name).html() + '">' + $('<span>').text(db.name).html() + '</option>');
                });
                databaseSelect.trigger('change');

                // Restore database after options loaded
                if (savedParams && savedParams.database) {
                    databaseSelect.val(savedParams.database).trigger('change');
                }
            },
            error: function (xhr) {
                var msg = 'Failed to load databases.';
                try { var r = xhr.responseJSON; if (r && r.message) msg = r.message; } catch {}
                showError(msg);
            }
        });

        // When database changes, load tables
        databaseSelect.on('change', function () {
            var db = $(this).val();

            // Destroy and recreate Select2 for table
            tableSelect.select2('destroy');
            tableSelect.empty();
            tableSelect.prop('disabled', true);
            tableSelect.select2({
                width: '100%',
                placeholder: 'All Tables (select to narrow)'
            });

            if (!db) return;

            var req = $.extend({}, creds, { database: db });

            $.ajax({
                url: apiBase + '/tables',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(req),
                success: function (tables) {
                    tables.forEach(function (t) {
                        var label = t.schema + '.' + t.name;
                        tableSelect.append('<option value="' + $('<span>').text(label).html() + '">' + $('<span>').text(label).html() + '</option>');
                    });
                    tableSelect.prop('disabled', false);
                    tableSelect.select2('destroy');
                    tableSelect.select2({
                        width: '100%',
                        placeholder: 'All Tables (select to narrow)'
                    });

                    // Restore table selections after options loaded
                    if (savedParams && savedParams.tables && savedParams.database === db) {
                        tableSelect.val(savedParams.tables).trigger('change');
                    }
                },
                error: function () {
                    tableSelect.prop('disabled', false);
                    tableSelect.select2('destroy');
                    tableSelect.select2({
                        width: '100%',
                        placeholder: 'All Tables (select to narrow)'
                    });
                }
            });
        });

        // Select All / Deselect All
        selectAllLink.on('click', function (e) {
            e.preventDefault();
            var allOptions = tableSelect.find('option');
            var allSelected = allOptions.length > 0 && allOptions.length === tableSelect.val()?.length;
            if (allSelected) {
                tableSelect.val(null).trigger('change');
                selectAllLink.text('Select All');
            } else {
                tableSelect.val(allOptions.map(function () { return $(this).val(); }).get()).trigger('change');
                selectAllLink.text('Deselect All');
            }
        });

        // Update link text when selection changes
        tableSelect.on('change', function () {
            var allOptions = tableSelect.find('option');
            var allSelected = allOptions.length > 0 && allOptions.length === (tableSelect.val()?.length || 0);
            selectAllLink.text(allSelected ? 'Deselect All' : 'Select All');
        });

        // Add column
        $('#btnAddColumn').on('click', function () {
            var container = $('#columnsContainer');
            var count = container.children().length;
            var row = $('<div class="column-row" data-index="' + count + '">' +
                '<input type="text" class="col-input" placeholder="e.g. Name, Email, Address">' +
                '<button class="btn btn-danger btn-delete-col">&times;</button>' +
                '</div>');
            container.append(row);
            row.find('.col-input').focus();
        });

        // Delete column (delegated)
        $('#columnsContainer').on('click', '.btn-delete-col', function () {
            var container = $('#columnsContainer');
            if (container.children().length <= 1) {
                showError('At least one column is required.');
                return;
            }
            $(this).closest('.column-row').remove();
        });

        // Back button
        $('#btnBack').on('click', function () {
            window.location.href = 'index.html';
        });

        // Restore column inputs
        if (savedParams && savedParams.columns) {
            // Remove default empty row
            $('#columnsContainer').empty();
            savedParams.columns.forEach(function (col) {
                var container = $('#columnsContainer');
                var count = container.children().length;
                var row = $('<div class="column-row" data-index="' + count + '">' +
                    '<input type="text" class="col-input" placeholder="e.g. Name, Email, Address" value="' + $('<span>').text(col).html() + '">' +
                    '<button class="btn btn-danger btn-delete-col">&times;</button>' +
                    '</div>');
                container.append(row);
            });
        }

        // Search button
        $('#btnSearch').on('click', function () {
            hideError();
            var db = databaseSelect.val();
            if (!db) {
                showError('Please select a database.');
                return;
            }

            var columns = [];
            $('.col-input').each(function () {
                var val = $(this).val().trim();
                if (val) columns.push(val);
            });

            if (columns.length === 0) {
                showError('Enter at least one column name.');
                return;
            }

            var tables = tableSelect.val() || null;

            setSearchParams({
                database: db,
                tables: tables,
                columns: columns
            });

            window.location.href = 'page3.html';
        });
    }

    // ---- PAGE 3: RESULTS ----
    function initPage3() {
        var creds = getCreds();
        var params = getSearchParams();

        if (!creds || !params) {
            window.location.href = 'index.html';
            return;
        }

        var req = $.extend({}, creds, params);

        // Show loading
        $('#loadingSection').removeClass('hidden');
        $('#resultsSection').addClass('hidden');
        hideError();

        $.ajax({
            url: apiBase + '/execute',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(req),
            dataType: 'json',
            success: function (resp) {
                $('#loadingSection').addClass('hidden');
                renderResults(resp);
            },
            error: function (xhr) {
                $('#loadingSection').addClass('hidden');
                var msg = 'Search failed.';
                try { var r = xhr.responseJSON; if (r && r.message) msg = r.message; } catch {}
                showError(msg);
            }
        });

        // Back to Search
        $('#btnBack').on('click', function () {
            window.location.href = 'page2.html';
        });

        // New Connection
        $('#btnNewConnection').on('click', function () {
            clearCreds();
            window.location.href = 'index.html';
        });

        // Download log
        $('#btnDownloadLog').on('click', function () {
            var filename = $(this).data('logfile');
            if (filename) {
                window.location.href = apiBase + '/log/' + encodeURIComponent(filename);
            }
        });
    }

    function renderResults(resp) {
        var results = resp.results || [];
        var totalTables = resp.totalTables || 0;
        var totalColumns = results.length;

        // Summary cards
        var summaryHtml =
            '<div class="card"><div class="number">' + totalTables + '</div><div class="label">Tables Found</div></div>' +
            '<div class="card"><div class="number">' + totalColumns + '</div><div class="label">Columns Matched</div></div>';
        $('#summaryCards').html(summaryHtml);

        // Table body
        var tbody = $('#resultsBody');
        tbody.empty();

        if (results.length === 0) {
            $('#emptyResults').removeClass('hidden');
            $('#resultsTableContainer table').addClass('hidden');
        } else {
            $('#emptyResults').addClass('hidden');
            $('#resultsTableContainer table').removeClass('hidden');

            results.forEach(function (r) {
                var row = $('<tr>' +
                    '<td>' + $('<span>').text(r.tableSchema).html() + '</td>' +
                    '<td><strong>' + $('<span>').text(r.tableName).html() + '</strong></td>' +
                    '<td><span class="badge badge-table">' + $('<span>').text(r.columnName).html() + '</span></td>' +
                    '<td>' + $('<span>').text(r.dataType).html() + '</td>' +
                    '</tr>');
                tbody.append(row);
            });
        }

        // Set log filename for download button
        if (resp.logFile) {
            $('#btnDownloadLog').data('logfile', resp.logFile).prop('disabled', false);
        } else {
            $('#btnDownloadLog').prop('disabled', true);
        }

        $('#resultsSection').removeClass('hidden');
    }

    // ---- INIT ----
    return {
        init: function () {
            var path = window.location.pathname.toLowerCase();

            if (path.endsWith('index.html') || path.endsWith('/') || path === '') {
                initPage1();
            } else if (path.endsWith('page2.html')) {
                initPage2();
            } else if (path.endsWith('page3.html')) {
                initPage3();
            }
        }
    };
})();

$(document).ready(function () {
    SPSearch.init();
});
