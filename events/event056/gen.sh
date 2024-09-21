lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 9.763963963963963 --fixed-mass2 44.72628628628629 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1021075500.3154159 \
--gps-end-time 1021082700.3154159 \
--d-distr volume \
--min-distance 936.3280094103568e3 --max-distance 936.3480094103568e3 \
--l-distr fixed --longitude -144.2571258544922 --latitude 14.956890106201172 --i-distr uniform \
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
