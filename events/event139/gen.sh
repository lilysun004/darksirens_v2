lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 33.96864864864865 --fixed-mass2 64.30854854854854 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1022551033.5851673 \
--gps-end-time 1022558233.5851673 \
--d-distr volume \
--min-distance 3931.753657322875e3 --max-distance 3931.7736573228754e3 \
--l-distr fixed --longitude 49.75559616088867 --latitude -36.15439224243164 --i-distr uniform \
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
