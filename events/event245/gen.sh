lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 37.83467467467468 --fixed-mass2 48.508268268268274 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1018592642.8905509 \
--gps-end-time 1018599842.8905509 \
--d-distr volume \
--min-distance 2676.9553086129367e3 --max-distance 2676.975308612937e3 \
--l-distr fixed --longitude -130.87713623046875 --latitude -7.797484397888184 --i-distr uniform \
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
