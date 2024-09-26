lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 21.53013013013013 --fixed-mass2 71.20016016016017 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1006517407.3561851 \
--gps-end-time 1006524607.3561851 \
--d-distr volume \
--min-distance 1667.5961300955444e3 --max-distance 1667.6161300955443e3 \
--l-distr fixed --longitude -112.030029296875 --latitude 20.76552391052246 --i-distr uniform \
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
