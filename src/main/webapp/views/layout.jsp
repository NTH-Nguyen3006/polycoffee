<%@page pageEncoding="utf-8" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>${not empty title ? title : 'Polycoffee'} — Thưởng thức vị cafe đích thực</title>
                <meta name="description"
                    content="Polycoffee — Quán cà phê phong cách hiện đại tại FPT Polytechnic. Hương vị đích thực, không gian ấm cúng.">

                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <link
                    href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800;900&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link rel="stylesheet" type="text/css"
                    href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">

                <style>
                    :root {
                        --coffee-dark: #1a0a00;
                        --coffee-mid: #3d1f00;
                        --coffee-light: #6b3a1f;
                        --coffee-gold: #e8821c;
                        --coffee-gold-light: #f6c06e;
                        --bs-primary: #e8821c;
                        --bs-primary-rgb: 232, 130, 28;
                    }

                    * {
                        box-sizing: border-box;
                    }

                    html {
    margin: 0;
    padding: 0;
}

body {
    font-family: 'Plus Jakarta Sans', sans-serif;
    background-color: #f8f9fa;
    -webkit-font-smoothing: antialiased;
    overflow-x: hidden;
}

                    /* Remove top padding for pages with fixed navbar */
                    body.has-fixed-nav>main {
                        padding-top: 0 !important;
                    }

                    main {
                        min-height: 75vh;
                    }

                    /* Smooth scroll */
                    html {
                        scroll-behavior: smooth;
                    }

                    /* ===== Fade in animation ===== */
                    .fade-in {
                        animation: fadeIn 0.5s ease-in;
                    }

                    @keyframes fadeIn {
                        from {
                            opacity: 0;
                            transform: translateY(10px);
                        }

                        to {
                            opacity: 1;
                            transform: translateY(0);
                        }
                    }

                    /* ===== Admin main ===== */
                    main.admin-main {
                        padding-top: 24px !important;
                        background: #f1f3f5;
                        min-height: calc(100vh - 60px);
                    }

                    /* ===== Scrollbar ===== */
                    ::-webkit-scrollbar {
                        width: 8px;
                    }

                    ::-webkit-scrollbar-track {
                        background: #f1f1f1;
                    }

                    ::-webkit-scrollbar-thumb {
                        background: var(--coffee-light);
                        border-radius: 4px;
                    }

                    ::-webkit-scrollbar-thumb:hover {
                        background: var(--coffee-mid);
                    }

                    /* ===== Selection ===== */
                    ::selection {
                        background: rgba(232, 130, 28, 0.25);
                        color: var(--coffee-dark);
                    }
                </style>
            </head>

            <body class="${isAdmin ? '' : 'has-fixed-nav'}">
                <jsp:include page="/views/partials/header.jsp" />

                <c:choose>
                    <c:when test="${fn:contains(view, '/admin/')}">
                        <main class="container admin-main py-4">
                            <jsp:include page="${view}" />
                        </main>
                    </c:when>
                    <c:otherwise>
                        <main style="min-height: 75vh; padding-top: 0;">
                            <jsp:include page="${view}" />
                        </main>
                    </c:otherwise>
                </c:choose>

                <jsp:include page="/views/partials/footer.jsp" />

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
                <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>

                <script>
                    console.log('%cPolycoffee System Ready! ☕', 'color: #e8821c; font-weight: bold; font-size: 14px;');
                </script>
            </body>

            </html>