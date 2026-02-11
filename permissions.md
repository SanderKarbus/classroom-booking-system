# Permissions testing

Created two roles:
- admin_role (full privileges)
- viewer_role (read-only access)

Tested by granting SELECT only to viewer_role.
Attempted INSERT as viewer and confirmed it fails.

REVOKE used to remove modification rights from viewer_role.
