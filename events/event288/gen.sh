lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 21.69821821821822 --fixed-mass2 68.25861861861863 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1007485928.6875703 \
--gps-end-time 1007493128.6875703 \
--d-distr volume \
--min-distance 3345.543536201069e3 --max-distance 3345.5635362010694e3 \
--l-distr fixed --longitude 60.65049362182617 --latitude -37.63962936401367 --i-distr uniform \
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
