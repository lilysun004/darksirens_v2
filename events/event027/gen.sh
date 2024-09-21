lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 40.18790790790791 --fixed-mass2 77.67155155155156 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1003524581.1831745 \
--gps-end-time 1003531781.1831745 \
--d-distr volume \
--min-distance 2432.3775620870347e3 --max-distance 2432.397562087035e3 \
--l-distr fixed --longitude -3.332611083984375 --latitude 14.072491645812988 --i-distr uniform \
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
