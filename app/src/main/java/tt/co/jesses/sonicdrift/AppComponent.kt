package tt.co.jesses.sonicdrift

import tt.co.jesses.sonicdrift.data.Repository
import tt.co.jesses.sonicdrift.domain.SetupManager

/**
 *
 * Created by jessescott on 2018-05-28.
 *
 */
interface AppComponent {

    /**
     *
     */
    val setupManager: SetupManager


    /**
     *
     */
    val repository: Repository


}