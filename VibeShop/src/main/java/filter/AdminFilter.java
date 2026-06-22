package filter;

import java.io.IOException;

import model.UserBean;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(urlPatterns = {
        "/jsp/admin/*",
        "/admin/*"
})
public class AdminFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/jsp/login.jsp?auth=required");
            return;
        }

        Object userObject = session.getAttribute("user");
        boolean admin = false;

        if (userObject instanceof UserBean) {
            UserBean user = (UserBean) userObject;
            admin = user.isAdmin();
        }

        Object roleObject = session.getAttribute("role");

        if (!admin && roleObject instanceof String) {
            admin = "ADMIN".equalsIgnoreCase((String) roleObject);
        }

        if (!admin) {
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
