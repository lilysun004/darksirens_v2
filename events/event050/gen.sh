lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 27.32916916916917 --fixed-mass2 58.84568568568569 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1021932331.7224046 \
--gps-end-time 1021939531.7224046 \
--d-distr volume \
--min-distance 1345.9430703061741e3 --max-distance 1345.9630703061741e3 \
--l-distr fixed --longitude 61.63665771484375 --latitude 0.41429784893989563 --i-distr uniform \
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
