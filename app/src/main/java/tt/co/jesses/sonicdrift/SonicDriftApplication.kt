package tt.co.jesses.sonicdrift

import android.app.Application
import android.util.Log

/**
 *
 * Created by jessescott on 2018-05-28.
 *
 */
class SonicDriftApplication: Application() {

    lateinit var appComponent: AppComponent

    init {
        instance = this
    }

    companion object {
        private var instance: SonicDriftApplication? = null

        fun applicationContext() : SonicDriftApplication {
            return instance!!
        }

        private const val TAG = "SonicDrift"
    }

    override fun onCreate() {
        super.onCreate()

        appComponent = DefaultAppComponent()

        Log.d(TAG, "Application Started")
    }

    fun getInstance(): SonicDriftApplication? {
        instance.let {
            return it
        }
    }

}