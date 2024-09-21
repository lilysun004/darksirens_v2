lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 25.31211211211211 --fixed-mass2 83.21845845845846 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1010209716.9477547 \
--gps-end-time 1010216916.9477547 \
--d-distr volume \
--min-distance 1443.5365201904922e3 --max-distance 1443.5565201904922e3 \
--l-distr fixed --longitude 91.63825988769531 --latitude 2.1615118980407715 --i-distr uniform \
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
