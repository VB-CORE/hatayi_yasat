# Security Policy

## Supported Versions

We release patches for security vulnerabilities. Which versions are eligible for receiving such patches depends on the CVSS v3.0 Rating:

| Version | Supported          |
| ------- | ------------------ |
| 8.x.x   | :white_check_mark: |
| 7.x.x   | :white_check_mark: |
| < 7.0   | :x:                |

## Reporting a Vulnerability

We take the security of our software seriously. If you believe you have found a security vulnerability, please report it to us as described below.

### Please do NOT:

- Open a public GitHub issue
- Discuss the vulnerability in public forums
- Share the vulnerability with others until it has been resolved

### Please DO:

1. **Email us directly** at: `grafikhtyapp@gmail.com`
   - Include "SECURITY" in the subject line
   - Provide a detailed description of the vulnerability
   - Include steps to reproduce the issue (if possible)
   - Suggest a fix if you have one

2. **Wait for our response**:
   - We will acknowledge receipt within 48 hours
   - We will provide an estimated timeline for a fix
   - We will keep you informed of our progress

3. **Responsible Disclosure**:
   - Allow us 90 days to address the vulnerability before public disclosure
   - We will credit you in our security advisories (unless you prefer to remain anonymous)

### What to Include in Your Report

- Type of vulnerability (e.g., XSS, SQL injection, authentication bypass)
- Full paths of source file(s) related to the vulnerability
- Location of the affected code (tag, branch, or commit hash)
- Step-by-step instructions to reproduce the issue
- Proof-of-concept or exploit code (if possible)
- Impact of the vulnerability

### Our Commitment

- We will respond to your report within 48 hours
- We will keep you informed of our progress
- We will work with you to understand and resolve the issue quickly
- We will credit you for responsible disclosure (unless you prefer anonymity)

## Security Best Practices

### For Contributors

- Never commit sensitive information (API keys, passwords, tokens)
- Use environment variables for configuration
- Review code changes for security implications
- Follow secure coding practices
- Keep dependencies up to date

### For Users

- Keep the app updated to the latest version
- Use strong authentication when available
- Report suspicious activity immediately
- Review app permissions regularly

## Known Security Considerations

### Firebase Configuration

This project uses Firebase for backend services. The Firebase API keys in the codebase are **client-side keys** and are safe to be public. Security is enforced through:

- **Firestore Security Rules**: Control database access
- **Firebase Storage Rules**: Control file storage access
- **Firebase Authentication**: User authentication and authorization

**Important**: Always configure proper Security Rules in your Firebase Console before deploying to production.

### Environment Variables

- Never commit `.env` files
- Use `.env.example` as a template
- For production, use Firebase Functions config or secure environment variable management

### Signing Keys

- Android keystore files (`.jks`, `.keystore`) are never committed
- Google Play service account keys are never committed
- These files are in `.gitignore` and should remain local only

## Security Updates

Security updates will be announced through:
- GitHub Security Advisories
- Release notes
- Email notifications (for critical issues)

## Additional Resources

- [Firebase Security Rules Documentation](https://firebase.google.com/docs/rules)
- [OWASP Mobile Security](https://owasp.org/www-project-mobile-security/)
- [Flutter Security Best Practices](https://docs.flutter.dev/security)

---

**Last Updated**: 2025-01-02

