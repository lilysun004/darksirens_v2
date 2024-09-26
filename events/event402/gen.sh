lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 34.052692692692695 --fixed-mass2 70.86398398398399 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1030128918.2167277 \
--gps-end-time 1030136118.2167277 \
--d-distr volume \
--min-distance 3239.792263088635e3 --max-distance 3239.8122630886355e3 \
--l-distr fixed --longitude 4.619353771209717 --latitude -13.811129570007324 --i-distr uniform \
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
