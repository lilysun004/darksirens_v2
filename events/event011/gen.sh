lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 38.08680680680681 --fixed-mass2 38.92724724724725 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1018248822.9116836 \
--gps-end-time 1018256022.9116836 \
--d-distr volume \
--min-distance 2948.148760743297e3 --max-distance 2948.1687607432973e3 \
--l-distr fixed --longitude 7.884750843048096 --latitude -37.42593765258789 --i-distr uniform \
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
