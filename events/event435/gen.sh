lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 17.916236236236237 --fixed-mass2 41.53261261261262 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1002416905.2486382 \
--gps-end-time 1002424105.2486382 \
--d-distr volume \
--min-distance 1036.3788240217125e3 --max-distance 1036.3988240217125e3 \
--l-distr fixed --longitude 112.49906921386719 --latitude 33.92399215698242 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower \
--L1=aLIGOZeroDetHighPower \
--V1=AdvVirgo

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 V1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
