lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 39.85173173173173 --fixed-mass2 65.65325325325325 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1020309715.3619637 \
--gps-end-time 1020316915.3619637 \
--d-distr volume \
--min-distance 2983.9061874417853e3 --max-distance 2983.9261874417857e3 \
--l-distr fixed --longitude -118.76858520507812 --latitude 26.78956413269043 --i-distr uniform \
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
