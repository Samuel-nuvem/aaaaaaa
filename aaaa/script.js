// Scroll suave para navegação
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        document.querySelector(this.getAttribute('href')).scrollIntoView({
            behavior: 'smooth'
        });
    });
});

// Demo de Pagamento Stripe (substitua 'pk_test_...' pela sua chave pública)
const stripe = Stripe('pk_test_SUA_CHAVE_PUBLICA_AQUI'); // Obtenha em stripe.com

document.getElementById('payButton').addEventListener('click', function() {
    // Cria sessão de checkout (em produção, chame API backend)
    fetch('/create-checkout-session', { method: 'POST' }) // Simule com backend real
        .then(response => response.json())
        .then(session => {
            return stripe.redirectToCheckout({ sessionId: session.id });
        })
        .then(result => {
            if (result.error) {
                document.getElementById('checkout-message').innerHTML = result.error.message;
            }
        });
});const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add('visible');
        }
    });
});
document.querySelectorAll('section').forEach(section => {
    observer.observe(section);
});

