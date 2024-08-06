lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 13.209769769769771 --fixed-mass2 51.11363363363364 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1005171153.828631 \
--gps-end-time 1005178353.828631 \
--d-distr volume \
--min-distance 2897.191086719211e3 --max-distance 2897.2110867192114e3 \
--l-distr fixed --longitude -66.31906127929688 --latitude 17.156982421875 --i-distr uniform \
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
