package tt.co.jesses.sonicdrift

import tt.co.jesses.sonicdrift.data.DefaultRepository
import tt.co.jesses.sonicdrift.data.Repository
import tt.co.jesses.sonicdrift.domain.DefaultSetupManager
import tt.co.jesses.sonicdrift.domain.SetupManager

/**
 *
 * Created by jessescott on 2018-05-28.
 *
 */
class DefaultAppComponent: AppComponent {

    override val setupManager: SetupManager by lazy {
        DefaultSetupManager()
    }

    override val repository: Repository by lazy {
        DefaultRepository()
    }

}