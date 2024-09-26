lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 35.061221221221224 --fixed-mass2 57.92120120120121 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1025160793.2114762 \
--gps-end-time 1025167993.2114762 \
--d-distr volume \
--min-distance 1731.5560615097434e3 --max-distance 1731.5760615097433e3 \
--l-distr fixed --longitude 41.494319915771484 --latitude 50.89936447143555 --i-distr uniform \
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
