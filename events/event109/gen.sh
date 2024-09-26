lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 4.973453453453454 --fixed-mass2 18.25241241241241 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1021101690.454805 \
--gps-end-time 1021108890.454805 \
--d-distr volume \
--min-distance 575.0583156409105e3 --max-distance 575.0783156409104e3 \
--l-distr fixed --longitude -44.02984619140625 --latitude 27.24574089050293 --i-distr uniform \
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
