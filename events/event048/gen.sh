lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 13.545945945945945 --fixed-mass2 61.703183183183185 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1019871778.9094868 \
--gps-end-time 1019878978.9094868 \
--d-distr volume \
--min-distance 2348.93553459227e3 --max-distance 2348.9555345922704e3 \
--l-distr fixed --longitude -66.57351684570312 --latitude -36.59012985229492 --i-distr uniform \
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
