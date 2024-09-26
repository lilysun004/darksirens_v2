lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 13.966166166166165 --fixed-mass2 77.08324324324325 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1029016960.8771234 \
--gps-end-time 1029024160.8771234 \
--d-distr volume \
--min-distance 802.1550993691524e3 --max-distance 802.1750993691523e3 \
--l-distr fixed --longitude 22.45320701599121 --latitude -3.5655739307403564 --i-distr uniform \
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
