package tt.co.jesses.sonicdrift.domain

import io.reactivex.Observable

/**
 *
 * Created by jessescott on 2018-05-28.
 *
 */
interface SetupManager {

    /**
     * Function
     */
    fun setup()

    /**
     * Function to determine if database is present and ready to transact with
     */
    fun databaseReady(): Observable<Boolean>

    /**
     * Function to determine if location permissions are granted and ready to transact with
     */
    fun locationReady(): Observable<Boolean>

}