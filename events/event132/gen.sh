lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 40.01981981981982 --fixed-mass2 59.433993993993994 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1026842079.4332922 \
--gps-end-time 1026849279.4332922 \
--d-distr volume \
--min-distance 1175.9910435032364e3 --max-distance 1176.0110435032364e3 \
--l-distr fixed --longitude 162.7471923828125 --latitude -77.4634017944336 --i-distr uniform \
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
