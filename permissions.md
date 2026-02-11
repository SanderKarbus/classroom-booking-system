# Permissions testing

Created two roles:
- admin_role (full privileges)
- viewer_role (read-only access)

Tested by granting SELECT only to viewer_role.
Attempted INSERT as viewer and confirmed it fails.

REVOKE used to remove modification rights from viewer_role.

## How tested

1. Connected as postgres (admin).
2. Executed permissions.sql to create roles and grant rights.

Admin role:
- Verified SELECT, INSERT, UPDATE, DELETE all work on booking table.

Viewer role:
- GRANT SELECT ON booking TO viewer_role;
- Confirmed SELECT works.
- Attempted INSERT INTO booking (...) → received permission denied error.
- Used REVOKE INSERT, UPDATE, DELETE FROM viewer_role.

Confirmed viewer_role has read-only access.

