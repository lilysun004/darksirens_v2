lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 14.386386386386388 --fixed-mass2 57.33289289289289 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1015758122.6653242 \
--gps-end-time 1015765322.6653242 \
--d-distr volume \
--min-distance 1368.285999536954e3 --max-distance 1368.305999536954e3 \
--l-distr fixed --longitude -65.69790649414062 --latitude 37.60053634643555 --i-distr uniform \
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
