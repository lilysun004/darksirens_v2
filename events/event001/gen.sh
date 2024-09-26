lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 41.78474474474475 --fixed-mass2 58.00524524524525 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1017767582.2013177 \
--gps-end-time 1017774782.2013177 \
--d-distr volume \
--min-distance 2964.3544431748846e3 --max-distance 2964.374443174885e3 \
--l-distr fixed --longitude 177.16864013671875 --latitude -15.286613464355469 --i-distr uniform \
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
