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

    // ---- SAVED ACCOUNTS ----
    function getSavedAccounts() {
        try {
            return JSON.parse(localStorage.getItem('spsearch_saved_accounts')) || [];
        } catch { return []; }
    }

    function setSavedAccounts(accounts) {
        localStorage.setItem('spsearch_saved_accounts', JSON.stringify(accounts));
    }

    function addSavedAccount(creds) {
        var accounts = getSavedAccounts();
        var idx = -1;
        for (var i = 0; i < accounts.length; i++) {
            if (accounts[i].server === creds.server && accounts[i].username === creds.username) {
                idx = i;
                break;
            }
        }
        if (idx !== -1) accounts.splice(idx, 1);
        accounts.unshift({
            server: creds.server,
            username: creds.username || '',
            password: creds.password || '',
            port: creds.port || 1433
        });
        setSavedAccounts(accounts);
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
                    addSavedAccount(creds);
                    window.location.href = '/search';
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

        // ---- Account Suggestions ----
        var suggestionBox = $('#suggestionBox');
        var serverInput = $('#server');

        function renderSuggestions() {
            var accounts = getSavedAccounts();
            if (accounts.length === 0) {
                suggestionBox.addClass('hidden');
                return;
            }
            var html = '';
            accounts.forEach(function (acc, index) {
                var serverLabel = acc.server;
                var userLabel = acc.username || '(Windows Auth)';
                html += '<div class="suggestion-item" data-index="' + index + '">' +
                    '<div>' +
                    '<div class="suggestion-server">' + $('<span>').text(serverLabel).html() + '</div>' +
                    '<div class="suggestion-user">' + $('<span>').text(userLabel).html() + '</div>' +
                    '</div>' +
                    '<button class="suggestion-del" data-index="' + index + '">&times;</button>' +
                    '</div>';
            });
            suggestionBox.html(html).removeClass('hidden');
        }

        serverInput.on('focus', function () {
            renderSuggestions();
        });

        serverInput.on('click', function () {
            renderSuggestions();
        });

        serverInput.on('blur', function () {
            setTimeout(function () { suggestionBox.addClass('hidden'); }, 200);
        });

        suggestionBox.on('mousedown', '.suggestion-item', function (e) {
            if ($(e.target).hasClass('suggestion-del')) return;
            var index = $(this).data('index');
            var accounts = getSavedAccounts();
            var acc = accounts[index];
            if (!acc) return;
            $('#server').val(acc.server);
            $('#username').val(acc.username);
            $('#password').val(acc.password);
            if (acc.port) $('#port').val(acc.port);
            suggestionBox.addClass('hidden');
        });

        suggestionBox.on('click', '.suggestion-del', function (e) {
            e.stopPropagation();
            var index = $(this).data('index');
            var accounts = getSavedAccounts();
            accounts.splice(index, 1);
            setSavedAccounts(accounts);
            renderSuggestions();
        });
    }

    // ---- PAGE 2: SEARCH CONFIG ----
    function initPage2() {
        var creds = getCreds();
        if (!creds) {
            window.location.href = '/home';
            return;
        }

        var tableSelect = $('#tableSelect');
        var procedureSelect = $('#procedureSelect');
        var databaseSelect = $('#databaseSelect');
        var selectAllLink = $('#selectAllTables');
        var selectAllProcedures = $('#selectAllProcedures');
        var savedParams = getSearchParams();

        // Init Select2 on database
        databaseSelect.select2({ width: '100%' });

        // Init Select2 on table (multi-select)
        tableSelect.select2({
            width: '100%',
            placeholder: 'All Tables (select to narrow)'
        });

        // Init Select2 on procedure (multi-select)
        procedureSelect.select2({
            width: '100%',
            placeholder: 'All Procedures (select to narrow)'
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

        // When database changes, load tables and procedures
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

            // Destroy and recreate Select2 for procedure
            procedureSelect.select2('destroy');
            procedureSelect.empty();
            procedureSelect.prop('disabled', true);
            procedureSelect.select2({
                width: '100%',
                placeholder: 'All Procedures (select to narrow)'
            });

            if (!db) return;

            var req = $.extend({}, creds, { database: db });

            // Load tables
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

            // Load procedures
            $.ajax({
                url: apiBase + '/procedures',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(req),
                success: function (procedures) {
                    procedures.forEach(function (p) {
                        var label = p.schema + '.' + p.name;
                        procedureSelect.append('<option value="' + $('<span>').text(label).html() + '">' + $('<span>').text(label).html() + '</option>');
                    });
                    procedureSelect.prop('disabled', false);
                    procedureSelect.select2('destroy');
                    procedureSelect.select2({
                        width: '100%',
                        placeholder: 'All Procedures (select to narrow)'
                    });

                    // Restore procedure selections after options loaded
                    if (savedParams && savedParams.procedures && savedParams.database === db) {
                        procedureSelect.val(savedParams.procedures).trigger('change');
                    }
                },
                error: function () {
                    procedureSelect.prop('disabled', false);
                    procedureSelect.select2('destroy');
                    procedureSelect.select2({
                        width: '100%',
                        placeholder: 'All Procedures (select to narrow)'
                    });
                }
            });
        });

        // Select All / Deselect All for tables
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

        // Select All / Deselect All for procedures
        selectAllProcedures.on('click', function (e) {
            e.preventDefault();
            var allOptions = procedureSelect.find('option');
            var allSelected = allOptions.length > 0 && allOptions.length === procedureSelect.val()?.length;
            if (allSelected) {
                procedureSelect.val(null).trigger('change');
                selectAllProcedures.text('Select All');
            } else {
                procedureSelect.val(allOptions.map(function () { return $(this).val(); }).get()).trigger('change');
                selectAllProcedures.text('Deselect All');
            }
        });

        // Update link text when selection changes
        procedureSelect.on('change', function () {
            var allOptions = procedureSelect.find('option');
            var allSelected = allOptions.length > 0 && allOptions.length === (procedureSelect.val()?.length || 0);
            selectAllProcedures.text(allSelected ? 'Deselect All' : 'Select All');
        });

        // Add table
        $('#btnAddTable').on('click', function () {
            var container = $('#tablesContainer');
            var count = container.children().length;
            var row = $('<div class="column-row" data-index="' + count + '">' +
                '<input type="text" class="table-input" placeholder="e.g. Patient, Order, Invoice">' +
                '<button class="btn btn-danger btn-delete-table">&times;</button>' +
                '</div>');
            container.append(row);
            row.find('.table-input').focus();
        });

        // Delete table (delegated)
        $('#tablesContainer').on('click', '.btn-delete-table', function () {
            $(this).closest('.column-row').remove();
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

        // Add SP Name
        $('#btnAddSpName').on('click', function () {
            var container = $('#spNamesContainer');
            var count = container.children().length;
            var row = $('<div class="column-row" data-index="' + count + '">' +
                '<input type="text" class="sp-name-input" placeholder="e.g. GetPatient, sp_help">' +
                '<button class="btn btn-danger btn-delete-sp-name">&times;</button>' +
                '</div>');
            container.append(row);
            row.find('.sp-name-input').focus();
        });

        // Delete SP Name (delegated)
        $('#spNamesContainer').on('click', '.btn-delete-sp-name', function () {
            $(this).closest('.column-row').remove();
        });

        // Add SP Param
        $('#btnAddSpParam').on('click', function () {
            var container = $('#spParamsContainer');
            var count = container.children().length;
            var row = $('<div class="column-row" data-index="' + count + '">' +
                '<input type="text" class="sp-param-input" placeholder="e.g. @PatientId, @Name">' +
                '<button class="btn btn-danger btn-delete-sp-param">&times;</button>' +
                '</div>');
            container.append(row);
            row.find('.sp-param-input').focus();
        });

        // Delete SP Param (delegated)
        $('#spParamsContainer').on('click', '.btn-delete-sp-param', function () {
            $(this).closest('.column-row').remove();
        });

        // Back button
        $('#btnBack').on('click', function () {
            window.location.href = '/home';
        });

        // Sign Out button
        $('#btnSignOut').on('click', function () {
            clearCreds();
            window.location.href = '/home';
        });

        // Restore table inputs
        if (savedParams && savedParams.tableNames) {
            $('#tablesContainer').empty();
            savedParams.tableNames.forEach(function (name) {
                var container = $('#tablesContainer');
                var count = container.children().length;
                var row = $('<div class="column-row" data-index="' + count + '">' +
                    '<input type="text" class="table-input" placeholder="e.g. Patient, Order, Invoice" value="' + $('<span>').text(name).html() + '">' +
                    '<button class="btn btn-danger btn-delete-table">&times;</button>' +
                    '</div>');
                container.append(row);
            });
        }

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

        // Restore SP name inputs
        if (savedParams && savedParams.spNames) {
            $('#spNamesContainer').empty();
            savedParams.spNames.forEach(function (name) {
                var container = $('#spNamesContainer');
                var count = container.children().length;
                var row = $('<div class="column-row" data-index="' + count + '">' +
                    '<input type="text" class="sp-name-input" placeholder="e.g. GetPatient, sp_help" value="' + $('<span>').text(name).html() + '">' +
                    '<button class="btn btn-danger btn-delete-sp-name">&times;</button>' +
                    '</div>');
                container.append(row);
            });
        }

        // Restore SP param inputs
        if (savedParams && savedParams.spParams) {
            $('#spParamsContainer').empty();
            savedParams.spParams.forEach(function (param) {
                var container = $('#spParamsContainer');
                var count = container.children().length;
                var row = $('<div class="column-row" data-index="' + count + '">' +
                    '<input type="text" class="sp-param-input" placeholder="e.g. @PatientId, @Name" value="' + $('<span>').text(param).html() + '">' +
                    '<button class="btn btn-danger btn-delete-sp-param">&times;</button>' +
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

            var tableNames = [];
            $('.table-input').each(function () {
                var val = $(this).val().trim();
                if (val) tableNames.push(val);
            });

            var columns = [];
            $('.col-input').each(function () {
                var val = $(this).val().trim();
                if (val) columns.push(val);
            });

            if (columns.length === 0) {
                showError('Enter at least one column name.');
                return;
            }

            var spNames = [];
            $('.sp-name-input').each(function () {
                var val = $(this).val().trim();
                if (val) spNames.push(val);
            });

            var spParams = [];
            $('.sp-param-input').each(function () {
                var val = $(this).val().trim();
                if (val) spParams.push(val);
            });

            var tables = tableSelect.val() || null;
            var procedures = procedureSelect.val() || null;

            setSearchParams({
                database: db,
                tables: tables,
                tableNames: tableNames,
                procedures: procedures,
                columns: columns,
                spNames: spNames,
                spParams: spParams
            });

            window.location.href = '/result';
        });
    }

    // ---- PAGE 3: RESULTS ----
    function initPage3() {
        var creds = getCreds();
        var params = getSearchParams();

        if (!creds || !params) {
            window.location.href = '/home';
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
            window.location.href = '/search';
        });

        // New Connection
        $('#btnNewConnection').on('click', function () {
            clearCreds();
            window.location.href = '/home';
        });

        // Download log
        $('#btnDownloadLog').on('click', function () {
            var filename = $(this).data('logfile');
            if (filename) {
                window.location.href = apiBase + '/log/' + encodeURIComponent(filename);
            }
        });

        // Row click — show schema modal
        $('#resultsBody').on('click', '.result-row', function () {
            try {
                var schema = $(this).data('schema');
                var table = $(this).data('table');

                $('#schemaModalLabel').text('Schema: ' + schema + '.' + table);
                $('#schemaLoading').removeClass('hidden');
                $('#schemaContent').addClass('hidden');
                $('#schemaError').addClass('hidden');

                var schemaReq = $.extend({}, creds, {
                    database: params.database,
                    tableSchema: schema,
                    tableName: table
                });

                $.ajax({
                    url: apiBase + '/schema',
                    method: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(schemaReq),
                    success: function (resp) {
                        $('#schemaLoading').addClass('hidden');

                        var colTbody = $('#schemaColumnsTable tbody');
                        colTbody.empty();
                        resp.columns.forEach(function (col) {
                            colTbody.append('<tr>' +
                                '<td><strong>' + $('<span>').text(col.columnName).html() + '</strong></td>' +
                                '<td>' + $('<span>').text(col.dataType).html() + '</td>' +
                                '<td>' + $('<span>').text(col.isNullable).html() + '</td>' +
                                '<td>' + (col.maxLength != null ? col.maxLength : '&mdash;') + '</td>' +
                                '</tr>');
                        });

                        var recThead = $('#schemaRecordsTable thead tr');
                        var recTbody = $('#schemaRecordsTable tbody');
                        recThead.empty();
                        recTbody.empty();

                        if (resp.sampleRecords && resp.sampleRecords.length > 0) {
                            var headers = Object.keys(resp.sampleRecords[0]);
                            headers.forEach(function (h) {
                                recThead.append('<th>' + $('<span>').text(h).html() + '</th>');
                            });
                            resp.sampleRecords.forEach(function (rec) {
                                var cells = '';
                                headers.forEach(function (h) {
                                    var val = rec[h];
                                    cells += '<td>' + (val != null ? $('<span>').text(String(val)).html() : '<em>null</em>') + '</td>';
                                });
                                recTbody.append('<tr>' + cells + '</tr>');
                            });
                        } else {
                            recTbody.append('<tr><td class="text-muted">No sample records found.</td></tr>');
                        }

                        $('#schemaContent').removeClass('hidden');
                    },
                    error: function (xhr) {
                        $('#schemaLoading').addClass('hidden');
                        var msg = 'Failed to load schema.';
                        try { var r = xhr.responseJSON; if (r && r.message) msg = r.message; } catch {}
                        $('#schemaError').text(msg).removeClass('hidden');
                    }
                });

                var modalEl = document.getElementById('schemaModal');
                if (modalEl) {
                    var modal = bootstrap.Modal.getOrCreateInstance(modalEl);
                    modal.show();
                }
            } catch (e) {
                console.error('Schema modal error:', e);
            }
        });
    }

    function renderResults(resp) {
        var results = resp.results || [];
        var totalTables = resp.totalTables || 0;
        var totalColumns = results.length;
        var procResults = resp.procedureResults || [];
        var totalProcedures = resp.totalProcedures || 0;

        // Summary cards
        var summaryHtml =
            '<div class="card"><div class="number">' + totalTables + '</div><div class="label">Tables Found</div></div>' +
            '<div class="card"><div class="number">' + totalColumns + '</div><div class="label">Columns Matched</div></div>' +
            '<div class="card"><div class="number">' + totalProcedures + '</div><div class="label">Procedures Found</div></div>';
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
                var row = $('<tr class="result-row" data-schema="' + $('<span>').text(r.tableSchema).html() + '" data-table="' + $('<span>').text(r.tableName).html() + '">' +
                    '<td>' + $('<span>').text(r.tableSchema).html() + '</td>' +
                    '<td><strong>' + $('<span>').text(r.tableName).html() + '</strong></td>' +
                    '<td><span class="badge badge-table">' + $('<span>').text(r.columnName).html() + '</span></td>' +
                    '<td>' + $('<span>').text(r.dataType).html() + '</td>' +
                    '</tr>');
                tbody.append(row);
            });
        }

        // Procedure results
        var procTbody = $('#procedureResultsBody');
        procTbody.empty();

        if (procResults.length === 0) {
            $('#emptyProcedureResults').removeClass('hidden');
            $('#procedureResultsContainer table').addClass('hidden');
        } else {
            $('#emptyProcedureResults').addClass('hidden');
            $('#procedureResultsContainer table').removeClass('hidden');

            procResults.forEach(function (p) {
                var def = p.definition || '';
                var truncated = def.length > 200 ? def.substring(0, 200) + '...' : def;
                var row = $('<tr>' +
                    '<td>' + $('<span>').text(p.procedureSchema).html() + '</td>' +
                    '<td><strong>' + $('<span>').text(p.procedureName).html() + '</strong></td>' +
                    '<td style="font-family: monospace; font-size: 0.8rem; white-space: pre-wrap; max-width: 400px;">' + $('<span>').text(truncated).html() + '</td>' +
                    '</tr>');
                procTbody.append(row);
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

            if (path.endsWith('index.html') || path.endsWith('sign.html') || path.endsWith('/') || path === '' || path.endsWith('/home')) {
                initPage1();
            } else if (path.endsWith('page2.html') || path.endsWith('search.html') || path.endsWith('/search')) {
                initPage2();
            } else if (path.endsWith('page3.html') || path.endsWith('result.html') || path.endsWith('/result')) {
                initPage3();
            }
        }
    };
})();

$(document).ready(function () {
    SPSearch.init();
});
