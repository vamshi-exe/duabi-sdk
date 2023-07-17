package com.example.dubai_sdk_kotlin

import android.content.Intent
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import mumbai.dev.sdkdubai.*
import mumbai.dev.sdkdubai.externalModel.*

class MainActivity: FlutterActivity(), CustomModel.OnCustomStateListener {

    private val CHANNEL = "plugin_ccavenue";

    companion object {
        private var flutterResult: MethodChannel.Result? = null
    }


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            // Note: this method is invoked on the main thread.
            if (call.method == "payCCAvenue") {
                MainActivity.flutterResult = result
                val mId = call.argument<Any>("mId").toString()
                Log.d("myTag", mId)
                //   Toast.makeText(getApplicationContext(),"mid : called",Toast.LENGTH_LONG).show();
                CustomModel.getInstance().setListener(this)
                val m = MerchantDetails()
                m.access_code = call.argument<Any>("accessCode").toString()
                m.merchant_id = call.argument<Any>("mId").toString()
                m.currency = call.argument<Any>("currency").toString()
                m.amount = call.argument<Any>("amount").toString()
                m.redirect_url = call.argument<Any>("redirect_url").toString()
                m.cancel_url = call.argument<Any>("cancel_url").toString()
                m.rsa_url = call.argument<Any>("rsa_url").toString()
                m.order_id = call.argument<Any>("order_id").toString()
                m.customer_id = call.argument<Any>("customer_id").toString()
                m.isShow_addr = true
                m.isCCAvenue_promo = true
                m.promo_code = call.argument<Any>("promo").toString()
                m.env_type = call.argument<Any>("envType").toString()
                m.add1 = call.argument<Any>("merchantParam1").toString()
                m.add2 = call.argument<Any>("merchantParam2").toString()
                m.add3 = call.argument<Any>("merchantParam3").toString()
                m.add4 = call.argument<Any>("merchantParam4").toString()
                m.add5 = call.argument<Any>("merchantParam5").toString()
                val b = BillingAddress()
                b.name = call.argument<Any>("billing_name").toString()
                b.address = call.argument<Any>("billing_address").toString()
                b.country = call.argument<Any>("billing_country").toString()
                b.state = call.argument<Any>("billing_state").toString()
                b.city = call.argument<Any>("billing_city").toString()
                b.telephone = call.argument<Any>("billing_telephone").toString()
                b.email = call.argument<Any>("billing_email").toString()
                val s = ShippingAddress()
                s.name = call.argument<Any>("shipping_name").toString()
                s.address = call.argument<Any>("shipping_address").toString()
                s.country = call.argument<Any>("shipping_country").toString()
                s.state = call.argument<Any>("shipping_state").toString()
                s.city = call.argument<Any>("shipping_city").toString()
                s.telephone = call.argument<Any>("shipping_telephone").toString()
                val si = StandardInstructions()
                si.si_type = call.argument<Any>("siType").toString()
                si.si_mer_ref_no = call.argument<Any>("siRef").toString()
                si.si_is_setup_amt = call.argument<Any>("siSetupAmount").toString()
                si.si_amount  =call.argument<Any>("siAmount").toString()
                si.si_start_date = call.argument<Any>("siStartDate").toString()
                si.si_frequency_type = call.argument<Any>("siFreqType").toString()
                si.si_frequency = call.argument<Any>("siFreq").toString()
                si.si_bill_cycle = call.argument<Any>("siBillCycle").toString()

                val i = Intent(this, PaymentOptions::class.java)
                i.putExtra("merchant", m)
                i.putExtra("billing", b)
                i.putExtra("shipping", s)
                i.putExtra("standard instructions", si)
                startActivity(i)
            } else {
                result.notImplemented()
            }
        }
    }

    override fun stateChanged() {
        val modelState = CustomModel.getInstance().state
        runOnUiThread {MainActivity.flutterResult?.success(modelState) }
    }
}
    