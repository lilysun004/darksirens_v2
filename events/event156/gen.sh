lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 22.79079079079079 --fixed-mass2 76.66302302302303 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1012218404.7572176 \
--gps-end-time 1012225604.7572176 \
--d-distr volume \
--min-distance 1005.8580306098065e3 --max-distance 1005.8780306098065e3 \
--l-distr fixed --longitude -176.6877899169922 --latitude -30.12356185913086 --i-distr uniform \
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
