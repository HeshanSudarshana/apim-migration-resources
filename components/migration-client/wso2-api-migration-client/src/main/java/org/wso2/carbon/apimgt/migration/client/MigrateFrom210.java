/*
 * Copyright (c) 2019, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.wso2.carbon.apimgt.migration.client;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.wso2.carbon.apimgt.migration.APIMigrationException;
import org.wso2.carbon.apimgt.migration.client.sp_migration.APIMStatMigrationException;
import org.wso2.carbon.apimgt.migration.util.RegistryService;
import org.wso2.carbon.registry.core.exceptions.RegistryException;
import org.wso2.carbon.user.api.Tenant;
import org.wso2.carbon.user.api.UserStoreException;
import org.wso2.carbon.user.core.tenant.TenantManager;
import org.wso2.carbon.utils.CarbonUtils;
import org.wso2.carbon.utils.FileUtil;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class MigrateFrom210 extends MigrationClientBase implements MigrationClient {
    private static final Log log = LogFactory.getLog(MigrateFrom210.class);
    private RegistryService registryService;

    public MigrateFrom210(String tenantArguments, String blackListTenantArguments, String tenantRange,
                          RegistryService registryService, TenantManager tenantManager)
            throws UserStoreException, APIMigrationException {
        super(tenantArguments, blackListTenantArguments, tenantRange, tenantManager);
        this.registryService = registryService;
    }

    @Override
    public void databaseMigration() throws APIMigrationException {
    }

    @Override
    public void registryResourceMigration() throws APIMigrationException {
        rxtMigration(registryService);
        updateGenericAPIArtifacts(registryService);
    }

    @Override
    public void fileSystemMigration() throws APIMigrationException {

    }

    @Override
    public void cleanOldResources() throws APIMigrationException {

    }

    @Override
    public void statsMigration() throws APIMigrationException, APIMStatMigrationException {

    }

    @Override
    public void tierMigration(List<String> options) throws APIMigrationException {
    }

    @Override
    public void updateArtifacts() throws APIMigrationException {
    }

    @Override
    public void populateSPAPPs() throws APIMigrationException {
    }

    @Override
    public void populateScopeRoleMapping() throws APIMigrationException {
    }

    @Override
    public void scopeMigration() throws APIMigrationException {
    }

    @Override
    public void spMigration() throws APIMigrationException {
    }

    @Override
    public void updateScopeRoleMappings() throws APIMigrationException {
    }

    @Override
    public void registryDataPopulation() throws APIMigrationException {

    }

    @Override
    public void migrateTenantConfToDB() throws APIMigrationException {

    }
}
