document.addEventListener('DOMContentLoaded', function () {
    setupEmailCheck();
    setupSearchSuggestions();
    setupCatalogCartControls();
    setupCartPageControls();
    setupCheckoutExpiryMask();
    setupAdminProductFilter();

    function setupEmailCheck() {
        const emailInput = document.getElementById('email');
        if (!emailInput) return;

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

    function setupSearchSuggestions() {
        const searchInput = document.querySelector('.search-form input[name="ricerca"]');
        if (!searchInput) return;

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

    function setupCatalogCartControls() {
        document.querySelectorAll('.product-cart-control, .concert-cart-control').forEach(function (control) {
            const productId = control.getAttribute('data-product-id');
            const concertId = control.getAttribute('data-concert-id');
            const cartKey = control.getAttribute('data-cart-key');
            const addButton = control.querySelector('.merch-add-btn, .ticket-add-btn');
            const quantityControl = control.querySelector('.quantity-control');
            const qtyValue = control.querySelector('.qty-value');
            const plus = control.querySelector('.qty-plus');
            const minus = control.querySelector('.qty-minus');
            let pending = false;

            function send(action) {
                if (pending) return;
                pending = true;
                setCatalogBusy(true);

                const body = new URLSearchParams();
                body.set('ajax', 'true');
                body.set('quantity', '1');

                if (productId) {
                    body.set('idProdotto', productId);
                    body.set('action', action);
                } else {
                    body.set('idConcerto', concertId);
                    if (action === 'add') {
                        body.set('action', 'addConcert');
                    } else {
                        body.set('action', action === 'increaseProduct' ? 'increase' : 'decrease');
                        body.set('cartKey', cartKey);
                    }
                }

                fetch(getContextPath() + '/cart', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8',
                        'X-Requested-With': 'XMLHttpRequest'
                    },
                    body: body.toString()
                })
                    .then(function (response) { return response.json(); })
                    .then(function (data) {
                        const newQuantity = parseInt(data.quantity || 0, 10) || 0;
                        const newCartCount = parseInt(data.cartCount || 0, 10) || 0;
                        updateCatalogQuantity(newQuantity, newCartCount);
                    })
                    .catch(function () {})
                    .finally(function () {
                        pending = false;
                        setCatalogBusy(false);
                    });
            }

            function updateCatalogQuantity(quantity, cartCount) {
                const qty = Math.max(0, parseInt(quantity || 0, 10));
                qtyValue.textContent = qty;

                if (qty > 0) {
                    addButton.classList.add('is-hidden');
                    quantityControl.classList.remove('is-hidden');
                } else {
                    addButton.classList.remove('is-hidden');
                    quantityControl.classList.add('is-hidden');
                }

                updateCartBadges(cartCount);
            }

            function setCatalogBusy(isBusy) {
                [addButton, plus, minus].forEach(function (button) {
                    if (button) button.disabled = isBusy;
                });
            }

            if (addButton) addButton.addEventListener('click', function () { send('add'); });
            if (plus) plus.addEventListener('click', function () { send('increaseProduct'); });
            if (minus) minus.addEventListener('click', function () { send('decreaseProduct'); });
        });
    }

    function setupCartPageControls() {
        document.querySelectorAll('.cart-row[data-cart-key]').forEach(function (row) {
            bindCartRow(row);
        });

        const clearForm = document.querySelector('.cart-clear-form');
        if (clearForm) {
            clearForm.addEventListener('submit', function (event) {
                event.preventDefault();
                sendCartMutation('clear', '', null, Array.from(clearForm.querySelectorAll('button')));
            });
        }
    }

    function bindCartRow(row) {
        const cartKey = row.getAttribute('data-cart-key');
        const qtyForm = row.querySelector('.cart-qty-form');
        const removeForm = row.querySelector('.cart-remove-form');

        if (qtyForm) {
            qtyForm.querySelectorAll('button[name="action"]').forEach(function (button) {
                button.addEventListener('click', function (event) {
                    event.preventDefault();
                    sendCartMutation(button.value, cartKey, row, Array.from(qtyForm.querySelectorAll('button')));
                });
            });
        }

        if (removeForm) {
            removeForm.addEventListener('submit', function (event) {
                event.preventDefault();
                sendCartMutation('remove', cartKey, row, Array.from(removeForm.querySelectorAll('button')));
            });
        }
    }

    function sendCartMutation(action, cartKey, row, buttons) {
        setButtonsBusy(buttons, true);

        const body = new URLSearchParams();
        body.set('ajax', 'true');
        body.set('action', action);
        if (cartKey) body.set('cartKey', cartKey);

        fetch(getContextPath() + '/cart', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8',
                'X-Requested-With': 'XMLHttpRequest'
            },
            body: body.toString()
        })
            .then(function (response) { return response.json(); })
            .then(function (data) {
                const quantity = parseInt(data.quantity || 0, 10) || 0;
                const cartCount = parseInt(data.cartCount || 0, 10) || 0;

                if (action === 'clear') {
                    document.querySelectorAll('.cart-row[data-cart-key]').forEach(function (itemRow) { itemRow.remove(); });
                } else if (row) {
                    if (quantity <= 0) {
                        row.remove();
                    } else {
                        const qtyInput = row.querySelector('.qty-input');
                        const subtotal = row.querySelector('[data-cart-subtotal]');
                        if (qtyInput) qtyInput.value = quantity;
                        if (subtotal) subtotal.textContent = formatMoney(data.subtotal || 0);
                    }
                }

                updateCartBadges(cartCount);
                updateCartTotals(data.total || 0);
                updateEmptyCartState(cartCount <= 0);
            })
            .catch(function () {})
            .finally(function () { setButtonsBusy(buttons, false); });
    }

    function updateCartTotals(total) {
        document.querySelectorAll('[data-cart-total]').forEach(function (element) {
            element.textContent = formatMoney(total || 0);
        });
    }

    function updateEmptyCartState(empty) {
        const emptyMessage = document.getElementById('cart-empty-message');
        const checkoutLink = document.querySelector('[data-checkout-link]');
        const clearForm = document.querySelector('.cart-clear-form');

        if (emptyMessage) emptyMessage.style.display = empty ? '' : 'none';
        if (checkoutLink) checkoutLink.style.display = empty ? 'none' : 'flex';
        if (clearForm) clearForm.style.display = empty ? 'none' : '';
    }

    function setupCheckoutExpiryMask() {
        const expiryInput = document.querySelector('input[name="expiry"]');
        if (!expiryInput) return;

        const message = document.createElement('small');
        message.className = 'checkout-expiry-message';
        message.style.display = 'block';
        message.style.marginTop = '6px';
        message.style.color = '#cc0000';
        expiryInput.parentElement.appendChild(message);

        expiryInput.addEventListener('input', function () {
            let digits = expiryInput.value.replace(/\D/g, '').slice(0, 4);

            if (digits.length >= 2) {
                expiryInput.value = digits.slice(0, 2) + (digits.length > 2 ? '/' + digits.slice(2) : '/');
            } else {
                expiryInput.value = digits;
            }

            validateExpiryInput();
        });

        expiryInput.addEventListener('blur', validateExpiryInput);

        function validateExpiryInput() {
            const value = expiryInput.value;
            const monthPart = value.slice(0, 2);
            const month = parseInt(monthPart, 10);

            if (monthPart.length === 2 && month > 12) {
                const text = 'Il mese non può essere superiore a 12.';
                expiryInput.setCustomValidity(text);
                message.textContent = text;
                return;
            }

            if (monthPart.length === 2 && month === 0) {
                const text = 'Il mese deve essere compreso tra 01 e 12.';
                expiryInput.setCustomValidity(text);
                message.textContent = text;
                return;
            }

            expiryInput.setCustomValidity('');
            message.textContent = '';
        }
    }

    function setupAdminProductFilter() {
        const adminSearch = document.getElementById('searchProduct');
        const table = document.getElementById('adminProductsTable');
        if (!adminSearch || !table) return;

        adminSearch.addEventListener('input', function () {
            const value = adminSearch.value.toLowerCase();
            table.querySelectorAll('tbody tr').forEach(function (row) {
                row.style.display = row.textContent.toLowerCase().indexOf(value) >= 0 ? '' : 'none';
            });
        });
    }

    function updateCartBadges(count) {
        document.querySelectorAll('.cart-count').forEach(function (badge) {
            badge.textContent = count;
            badge.style.display = count > 0 ? 'flex' : 'none';
        });
    }

    function setButtonsBusy(buttons, isBusy) {
        (buttons || []).forEach(function (button) {
            if (button) button.disabled = isBusy;
        });
    }

    function formatMoney(value) {
        const amount = Number(value || 0);
        return new Intl.NumberFormat('it-IT', { style: 'currency', currency: 'EUR' }).format(amount);
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
