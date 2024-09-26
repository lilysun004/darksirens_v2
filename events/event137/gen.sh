lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 9.932052052052052 --fixed-mass2 38.254894894894896 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1004643454.8684416 \
--gps-end-time 1004650654.8684416 \
--d-distr volume \
--min-distance 957.422530688917e3 --max-distance 957.442530688917e3 \
--l-distr fixed --longitude -151.99722290039062 --latitude 2.3709354400634766 --i-distr uniform \
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
