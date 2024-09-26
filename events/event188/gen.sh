lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 35.061221221221224 --fixed-mass2 80.86522522522523 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1016637157.9954039 \
--gps-end-time 1016644357.9954039 \
--d-distr volume \
--min-distance 3687.7717347368975e3 --max-distance 3687.791734736898e3 \
--l-distr fixed --longitude 176.20156860351562 --latitude -56.48107147216797 --i-distr uniform \
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
