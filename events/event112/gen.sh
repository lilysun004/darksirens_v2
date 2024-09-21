lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 36.321881881881886 --fixed-mass2 3.2925725725725727 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1030066275.8640199 \
--gps-end-time 1030073475.8640199 \
--d-distr volume \
--min-distance 886.5214195983089e3 --max-distance 886.5414195983088e3 \
--l-distr fixed --longitude -157.5278778076172 --latitude 40.904720306396484 --i-distr uniform \
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
