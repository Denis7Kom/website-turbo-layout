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
                .catch(function () { message.textContent = ''; });
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

            fetch(searchInput.form.action + '?q=' + encodeURIComponent(value))
                .then(function (response) { return response.json(); })
                .then(function (items) {
                    results.innerHTML = '';
                    items.slice(0, 10).forEach(function (item) {
                        const row = document.createElement('a');
                        row.className = 'search-suggestion-row';
                        row.href = getContextPath() + item.url;
                        row.innerHTML = '<span>' + escapeHtml(item.type) + '</span><strong>' + escapeHtml(item.title) + '</strong><small>' + escapeHtml(item.subtitle || '') + '</small>';
                        results.appendChild(row);
                    });
                })
                .catch(function () { results.innerHTML = ''; });
        });
    }

    document.querySelectorAll('.product-cart-control').forEach(function (control) {
        const productId = control.getAttribute('data-product-id');
        const addButton = control.querySelector('.merch-add-btn');
        const quantityControl = control.querySelector('.quantity-control');
        const qtyValue = control.querySelector('.qty-value');
        const plus = control.querySelector('.qty-plus');
        const minus = control.querySelector('.qty-minus');

        function send(action) {
            const body = new URLSearchParams();
            body.set('ajax', 'true');
            body.set('action', action);
            body.set('idProdotto', productId);
            body.set('quantity', '1');

            fetch(getContextPath() + '/cart', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8',
                    'X-Requested-With': 'XMLHttpRequest'
                },
                body: body.toString()
            })
                .then(function (response) { return response.json(); })
                .then(function (data) { updateQuantity(data.quantity, data.cartCount); })
                .catch(function () {});
        }

        function updateQuantity(quantity, cartCount) {
            const qty = parseInt(quantity || 0, 10);
            qtyValue.textContent = qty;
            if (qty > 0) {
                addButton.classList.add('is-hidden');
                quantityControl.classList.remove('is-hidden');
            } else {
                addButton.classList.remove('is-hidden');
                quantityControl.classList.add('is-hidden');
            }

            document.querySelectorAll('.cart-count').forEach(function (badge) {
                badge.textContent = cartCount;
            });
        }

        if (addButton) addButton.addEventListener('click', function () { send('add'); });
        if (plus) plus.addEventListener('click', function () { send('increaseProduct'); });
        if (minus) minus.addEventListener('click', function () { send('decreaseProduct'); });
    });

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

    function getContextPath() {
        const path = window.location.pathname;
        const secondSlash = path.indexOf('/', 1);
        return secondSlash === -1 ? '' : path.substring(0, secondSlash);
    }

    function escapeHtml(value) {
        return String(value || '').replace(/[&<>"']/g, function (char) {
            return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[char];
        });
    }
});
