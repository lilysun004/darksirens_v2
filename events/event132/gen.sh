lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 19.68116116116116 --fixed-mass2 55.652012012012015 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1002044381.5927005 \
--gps-end-time 1002051581.5927005 \
--d-distr volume \
--min-distance 1210.211820114499e3 --max-distance 1210.231820114499e3 \
--l-distr fixed --longitude 27.768198013305664 --latitude 1.2399381399154663 --i-distr uniform \
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
