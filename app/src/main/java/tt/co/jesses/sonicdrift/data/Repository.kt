package tt.co.jesses.sonicdrift.data

import io.reactivex.Observable

/**
 *
 * Created by jessescott on 2018-05-28.
 *
 */
interface Repository {

    /**
     *
     */
    fun databaseReady(): Observable<Boolean>

}