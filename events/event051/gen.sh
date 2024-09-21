lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 39.5995995995996 --fixed-mass2 67.33413413413413 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1000186843.5963098 \
--gps-end-time 1000194043.5963098 \
--d-distr volume \
--min-distance 2674.01219169056e3 --max-distance 2674.0321916905605e3 \
--l-distr fixed --longitude -45.329010009765625 --latitude 34.85879135131836 --i-distr uniform \
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
