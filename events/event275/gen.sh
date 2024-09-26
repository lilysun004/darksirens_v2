lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 77.83963963963964 --fixed-mass2 57.92120120120121 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1026519878.4801916 \
--gps-end-time 1026527078.4801916 \
--d-distr volume \
--min-distance 2603.3209615516676e3 --max-distance 2603.340961551668e3 \
--l-distr fixed --longitude 24.515811920166016 --latitude 24.412548065185547 --i-distr uniform \
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
