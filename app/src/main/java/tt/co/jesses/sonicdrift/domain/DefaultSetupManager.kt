package tt.co.jesses.sonicdrift.domain

import io.reactivex.Observable

/**
 *
 * Created by jessescott on 2018-05-28.
 *
 */
class DefaultSetupManager: SetupManager {

    override fun setup() {
        //DefaultRepository
    }

    override fun databaseReady(): Observable<Boolean> {

        return Observable.just(true)
    }

    override fun locationReady(): Observable<Boolean> {

        return Observable.just(true)
    }
}