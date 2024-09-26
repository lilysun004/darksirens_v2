lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 29.262182182182183 --fixed-mass2 68.09053053053053 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1025646047.1979715 \
--gps-end-time 1025653247.1979715 \
--d-distr volume \
--min-distance 4312.249193524281e3 --max-distance 4312.269193524281e3 \
--l-distr fixed --longitude 102.38650512695312 --latitude 73.34711456298828 --i-distr uniform \
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
