lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 33.38034034034034 --fixed-mass2 46.74334334334335 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1018291842.8995886 \
--gps-end-time 1018299042.8995886 \
--d-distr volume \
--min-distance 2720.6049608481985e3 --max-distance 2720.624960848199e3 \
--l-distr fixed --longitude -89.45379638671875 --latitude -39.163719177246094 --i-distr uniform \
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
