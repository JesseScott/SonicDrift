package tt.co.jesses.sonicdrift.data

import io.reactivex.Observable

/**
 *
 * Created by jessescott on 2018-05-28.
 *
 */
class DefaultRepository: Repository {
    override fun databaseReady(): Observable<Boolean> {

        return Observable.just(true)
    }
}