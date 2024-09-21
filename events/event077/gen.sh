lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 28.337697697697696 --fixed-mass2 58.761641641641646 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1029618279.1270843 \
--gps-end-time 1029625479.1270843 \
--d-distr volume \
--min-distance 2322.3575853245397e3 --max-distance 2322.37758532454e3 \
--l-distr fixed --longitude 150.70260620117188 --latitude -42.754302978515625 --i-distr uniform \
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
