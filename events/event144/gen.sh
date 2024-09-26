lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 36.65805805805806 --fixed-mass2 81.78970970970971 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1021590149.1470371 \
--gps-end-time 1021597349.1470371 \
--d-distr volume \
--min-distance 2951.7181417555803e3 --max-distance 2951.7381417555807e3 \
--l-distr fixed --longitude -117.53639221191406 --latitude -15.955950736999512 --i-distr uniform \
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
