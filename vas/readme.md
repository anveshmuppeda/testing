Subject: Proposed 3-Step Process for RDS DB Engine Upgrade Issue

Hi team,

Following up on yesterday’s RDS DB upgrade issue with the custom parameter group, here’s a summary of the problem and our proposed approach:

**Issue Recap:**  
When attempting a major engine version upgrade, we received the error:  
> "The current DB instance parameter group is custom. You must explicitly specify a new DB instance parameter group, either default or custom, for the engine version upgrade."

This error occurs even when the custom parameter group is aligned with the destination engine version family.

**Proposed 3-Step Update Process:**  
1. **Switch to Default Parameter Group (Current Engine Version):**  
   - Update the DB cluster parameter group to the default parameter group for the current engine version.  
   - *Example:* For Aurora PostgreSQL version 13, change to **default.aurora-postgresql13**.

2. **Upgrade Engine Version and Set Default for Destination:**  
   - Update the DB cluster and DB instance to the new engine version.  
   - Set the parameter group to the default parameter group for the destination engine version.  
   - *Example:* If upgrading to Aurora PostgreSQL 16.6, change to **default.aurora-postgresql16**.

3. **Apply Custom Parameter Group:**  
   - Finally, update the DB cluster parameter group to your desired custom parameter group that matches the new engine version.

This three‐step approach has been tested in our sandbox environment and works as expected.

Let’s proceed with this method during our upgrade today. Please review and let me know if you have any questions or concerns.

