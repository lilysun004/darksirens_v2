lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 2.6202202202202205 --fixed-mass2 59.85421421421422 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1021208499.0205811 \
--gps-end-time 1021215699.0205811 \
--d-distr volume \
--min-distance 571.0547827646155e3 --max-distance 571.0747827646155e3 \
--l-distr fixed --longitude 176.15969848632812 --latitude 28.543691635131836 --i-distr uniform \
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
