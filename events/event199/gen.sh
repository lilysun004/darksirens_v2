lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 12.033153153153155 --fixed-mass2 54.13921921921922 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1010202017.1222603 \
--gps-end-time 1010209217.1222603 \
--d-distr volume \
--min-distance 836.3009999646672e3 --max-distance 836.3209999646672e3 \
--l-distr fixed --longitude 52.26900863647461 --latitude -11.920027732849121 --i-distr uniform \
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
