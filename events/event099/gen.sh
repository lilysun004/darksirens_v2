lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 59.686126126126126 --fixed-mass2 64.64472472472472 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1010519687.8959613 \
--gps-end-time 1010526887.8959613 \
--d-distr volume \
--min-distance 981.1142682766573e3 --max-distance 981.1342682766573e3 \
--l-distr fixed --longitude 31.145517349243164 --latitude 6.210390090942383 --i-distr uniform \
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
