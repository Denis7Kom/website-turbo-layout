document.addEventListener('DOMContentLoaded', function () {
    const emailInput = document.getElementById('email');
    if (emailInput) {
        const message = document.createElement('small');
        message.id = 'email-check-message';
        emailInput.parentElement.appendChild(message);

        emailInput.addEventListener('input', function () {
            const value = emailInput.value.trim();
            if (value.length < 5) {
                message.textContent = '';
                return;
            }

            fetch(emailInput.form.action.replace('/register', '/check-email') + '?email=' + encodeURIComponent(value))
                .then(function (response) { return response.json(); })
                .then(function (data) {
                    if (!data.valid) {
                        message.textContent = 'Formato email non valido';
                    } else if (data.available) {
                        message.textContent = 'Email disponibile';
                    } else {
                        message.textContent = 'Email gia registrata';
                    }
                })
                .catch(function () {
                    message.textContent = '';
                });
        });
    }

    const searchInput = document.querySelector('.search-form input[name="ricerca"]');
    if (searchInput) {
        const results = document.createElement('div');
        results.className = 'search-suggestions';
        searchInput.parentElement.appendChild(results);

        searchInput.addEventListener('input', function () {
            const value = searchInput.value.trim();
            if (value.length < 2) {
                results.innerHTML = '';
                return;
            }

            const base = searchInput.form.action.replace('/Ricerca', '/search');
            fetch(base + '?q=' + encodeURIComponent(value))
                .then(function (response) { return response.json(); })
                .then(function (items) {
                    results.innerHTML = '';
                    items.forEach(function (item) {
                        const row = document.createElement('div');
                        row.className = 'search-suggestion-row';
                        row.textContent = item.name + ' - euro ' + item.price;
                        results.appendChild(row);
                    });
                })
                .catch(function () {
                    results.innerHTML = '';
                });
        });
    }

    const adminSearch = document.getElementById('searchProduct');
    const table = document.getElementById('adminProductsTable');
    if (adminSearch && table) {
        adminSearch.addEventListener('input', function () {
            const value = adminSearch.value.toLowerCase();
            table.querySelectorAll('tbody tr').forEach(function (row) {
                row.style.display = row.textContent.toLowerCase().indexOf(value) >= 0 ? '' : 'none';
            });
        });
    }
});
