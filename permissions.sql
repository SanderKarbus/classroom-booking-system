
-- Create roles
CREATE ROLE admin_role;
CREATE ROLE viewer_role;

-- Give admin full rights
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin_role;

-- Give viewer read-only access
GRANT SELECT ON ALL TABLES IN SCHEMA public TO viewer_role;

-- Example revoke
REVOKE INSERT, UPDATE, DELETE ON booking FROM viewer_role;
